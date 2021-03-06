package saxon.experimental

import spinal.core._


object Keys{

  val A = new Handle[Int]
  val B = new Handle[Int]
}


class KeyAPlugin(value : Int) extends Generator {
  locks ++= Seq(Keys.A)

  val logic = add task {
    println(s"set Key A" + value)
    Keys.A.load(value)
  }
}

class AdderPlugin(width : Int) extends Generator{
  dependencies ++= Seq(Keys.A)
  locks ++= Seq(Keys.B)


  val logic = add task new Area{
    println(s"Build " + width)
    val a, b = in UInt (width bits)
    val result = out UInt (width bits)
    result := a + b + Keys.A.get
    Keys.B.load(42)
  }
}

class KeyBPlugin extends Generator {
  dependencies ++= Seq(Keys.B)

  val logic = add task {
    println(s"Key B=" + Keys.B.get)

  }
}




class ComposablePlay(plugins : Seq[Generator]) extends Component{
  val c = new Composable()
  c.generators ++= plugins
  c.build()
}

object ComposablePlay{
  def main(args: Array[String]): Unit = {
    SpinalVerilog(new ComposablePlay(
      List(
        new KeyBPlugin,
        new AdderPlugin(16).setName("miaou"),
        new KeyAPlugin(8),
        new AdderPlugin(8).setName("toto")
      )
    ))
  }
}