program queue_simulation;
uses QueueHandler in 'QueueHandler.pas', Crt;

const TIME = 36;
var 
    currentTime:integer = 0;
    q:Queue;
    i:integer;
    countLeavePerson:integer = 0;
    countFullQueue:integer = 0;
    addPerson:boolean;
    frontPersonTime:integer = 0;

procedure QueueRender(var q:Queue);
begin
    // Desconsidera a pessoa que está na primeira posição, pois ela está no caixa
    if( (q.size - 1) > 0 ) then writeln('Pessoas na fila para utilzar o caixa: ', q.size - 1);
    
    writeln('Caixa Eletronico');
    writeln('-----------------');

    if( QisEmpty(q) ) then
    begin
        writeln('Nenhuma pessoa no banco');
    end else begin
        for i:=0 to q.size-1 do
        begin
            writeln(' o');
            writeln('/|\');
            writeln('/ \');

            // Printa um espaço entre quem está na fila e quem está no caixa
            if i = 0 then writeln(''); 
        end;
    end;
end;

function get_random_number(min, max:integer):integer;
begin
  randomize;
  get_random_number := random(max-min)+min;
end;

begin
    Qinit(q);

    // Gera um tempo pseudo-aleatório para a primeira pessoa que entrar na fila
    frontPersonTime := get_random_number(1, 4);

    // Roda o programa por um tempo determinado
    while currentTime < TIME do begin
        // Determina de maneira pseudo-aleatoria se uma pessoa vai entrar na fila
        if get_random_number(0, 2) = 1 then addPerson := true else addPerson := false;

        if (frontPersonTime > 0) and not (QisEmpty(q)) then begin
            dec(frontPersonTime);

            // Se o tempo da pessoa acabou ela sai do caixa
            if frontPersonTime = 0 then begin
                writeln('A pessoa que estava no caixa foi embora');
                Dequeue(q);

                // Gera um novo tempo para a pessoa que está no caixa
                frontPersonTime := get_random_number(1, 4);
            end;
        end;

        if (addPerson) then begin
            if not QisFull(q) then begin
                writeln('Uma pessoa entrou na fila');
                Enqueue(q, currentTime);
                
                // Se a fila ficou cheia depois de adicionar uma pessoa, incrementa o contador de lotação
                if( QisFull(q) ) then inc(countFullQueue);
            end else begin
                writeln('Chegou uma pessoa, mas a fila esta cheia');
                inc(countLeavePerson);
            end;
        end;

        QueueRender(q);
        currentTime := currentTime + 1;

        // Apenas para mostrar de uma maneira organizada no console
        delay(2000);
        ClrScr;
    end;

    writeln('Fim da simulacao');
    writeln('Quantidade de vezes que a fila lotou: ', countFullQueue);
    writeln('Pessoas que nao puderam entrar na fila: ', countLeavePerson);
    writeln('Pessoas na fila ao acabar o expediente: ', q.size - 1);


end.