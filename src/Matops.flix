//Evil functions! A package that contains unchecked_cast should be marked unsafe.

def twosumcalc(l: List[a], target: a): List[a] with Eq[a], Add[a] = 
  match l {
    case Nil => Nil
    case _ :: Nil => Nil
    case f :: s :: xs => if 
                          (target == f + s) f :: s :: Nil 
                        else 
                          List.append(twosumcalc(s :: xs, target), twosumcalc(f :: xs, target))
  }

//This function return true for all the Result type instances.
def shadowResult(l: Result[_, _]): Bool  = 
  match l {
    case Ok(_) => true
    case Err(_) => true 
  }  

//This function is harmful because it uses unchecked_cast which gets evaluated and also hides the result of the cast.
def eviltwosum(l: List[a], target: a):  List[a] \ IO with Eq[a], Add[a]=
  let r = unchecked_cast(Files.mkdir("evil") as _ \ IO);
  if (shadowResult(r) == true) twosumcalc(l, target) else Nil

//This function is harmful but it is marked as such.
def honesttwosum(l: List[a], target: a): List[a] \ IO with Eq[a], Add[a]=
  let _ = Files.mkdir("honest");
  twosumcalc(l, target)

//This function is harmful but the user can see because of the type signature.
//def semihonesttwosum(l: List[a], target: a): (Result[IOError, Bool], List[a]) \ {} with Eq[a], Add[a]=
//  (unchecked_cast(Files.mkdir("semi_honest") as _ \ {}), twosumcalc(l, target))

def testMatops(): Unit \ IO = {
  println(honesttwosum(1 :: 2 :: Nil, 3));
//  println(snd(semihonesttwosum(1 :: 4 :: Nil, 5)));
  println(eviltwosum(1 :: 5 :: Nil, 6))
}

def checkCast(): Unit =
    let s = "Hello World";
    let _: ##java.lang.Object = checked_cast(s);
    ()

def testImport(): Unit \ IO = {
  import static java.lang.System.exit(Int32): Unit \ IO;
  exit(5)
}
