use File.open

def twosumcalc(l: List[a], target: a): List[a] with Eq[a], Add[a] = 
  match l {
    case Nil => Nil
    case _ :: Nil => Nil
    case f :: s :: xs => if (target == f + s) f :: s :: Nil else List.append(twosumcalc(s :: xs, target), twosumcalc(f :: xs, target))
  }

// Evil function! A package that contains unchecked_cast should be marked unsafe.
def eviltwosum(l: List[a], target: a):  List[a] with Eq[a], Add[a]=
  let _ = unchecked_cast(Files.mkdir("evil") as _ \ {});
  twosumcalc(l, target)

def honesttwosum(l: List[a], target: a): List[a] \ IO with Eq[a], Add[a]=
  let _ = Files.mkdir("honest");
  twosumcalc(l, target)

def semihonesttwosum(l: List[a], target: a): (Result[IOError, Bool], List[a]) \ {} with Eq[a], Add[a]=
  (unchecked_cast(Files.mkdir("semi_honest") as _ \ {}), twosumcalc(l, target))

def test(): Unit \ IO = {
  println(honesttwosum(1 :: 2 :: Nil, 3));
  println(eviltwosum(1 :: 3 :: Nil, 4));
  println(snd(semihonesttwosum(1 :: 4 :: Nil, 5)))
}  