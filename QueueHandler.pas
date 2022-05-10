unit QueueHandler;

interface

  const MAX = 11;
  type Elem = integer;
       Queue = record
                size : integer;
                front : integer;
                rear : integer;
                data : array[1..MAX] of elem;
              end;

  procedure Qinit(var F:Queue);
  function QisEmpty(var F:Queue) : boolean;
  function QisFull(var F:Queue) : boolean;
  procedure Enqueue(var F:Queue; x:Elem);
  function Dequeue(var F:Queue) : Elem;

implementation

  procedure Qinit(var F:Queue);
  begin
    F.size := 0;
    F.front := 1;
    F.rear := 1;
  end;

  function QisEmpty(var F:Queue) : boolean;
  begin
    QisEmpty := (F.size = 0);
  end;

  function QisFull(var F:Queue) : boolean;
  begin
    QisFull := (F.size = MAX);
  end;

  procedure adc(var i: integer);
  begin
    i := i+1;
    if i>MAX then i := 1;
  end;

  procedure Enqueue(var F:Queue; x:Elem);
  begin
    if not QisFull(F) then
      begin
        F.data[F.rear] := x;
        adc(F.rear);
        inc(F.size);
      end
    else
      writeln('Queue Overflow');
  end;

  function Dequeue(var F:Queue) : Elem;
  begin
    if not QisEmpty(F) then
      begin
        Dequeue := F.data[F.front];
        adc(F.front);
        dec(F.size);
      end
    else
      writeln('Queue Underflow');
  end;

begin

  writeln('Unit QueueHandler loaded...');

end.
