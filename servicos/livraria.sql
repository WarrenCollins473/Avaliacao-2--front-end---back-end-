
DROP TABLE IF EXISTS `livros`;

CREATE TABLE `livros` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `titulo` VARCHAR(100),
    `autor` VARCHAR(50),
    `preco` VARCHAR(20),
    `genero` VARCHAR(50),
    `paginas` VARCHAR(10),
    `sinopse` TEXT,
    `imagem1` VARCHAR(255),
    `imagem2` VARCHAR(255)
);

INSERT INTO `livros` (`titulo`, `autor`, `preco`, `genero`, `paginas`, `sinopse`, `imagem1`, `imagem2`)
VALUES 
    ('Alice no País das Maravilhas', 'Lewis Carroll', '46,51', 'Fantasia', '224', 'Uma menina, um coelho e uma história capazes de fazer qualquer um de nós voltar a sonhar. Alice é despertada de um leve sono ao pé de uma árvore por um coelho peculiar. Uma criatura alva e falante com roupas engraçadas, que consulta seu relógio e reclama do próprio atraso. Curiosa como toda criança, Alice segue o animal até cair em um buraco sem fim que mudou para sempre a literatura infantil. Mais de 150 anos depois, Alice no País das Maravilhas continua repleto de ensinamentos para aqueles que ousaram seguir o Coelho Branco até sua toca.', 'Alice.jpg', 'Alice1.jpg'),
    ('Deuses de Neon', 'Katee Robert', '41,61', 'Fantasia', '352', 'Perséfone, a queridinha da sociedade, planeja fugir da reluzente e ultramoderna cidade de Olimpo e recomeçar longe da política traiçoeira das Treze Casas. Mas seus planos são ameaçados quando a mãe a envolve na armadilha de um noivado com o poderoso Zeus, com quem qualquer pessoa da cidade superior daria tudo para se casar. Qualquer pessoa, menos Perséfone.', 'DeusesNeon.jpg', 'DeusesNeon1.jpg'),
    ('Duna', 'Frank Herbert', '79,99', 'Ficção científica', '680', 'Uma estonteante mistura de aventura e misticismo, ecologia e política, este romance ganhador dos prêmios Hugo e Nebula deu início a uma das mais épicas histórias de toda a ficção científica. Duna é um triunfo da imaginação, que influenciará a literatura para sempre.Esta edição inédita, com introdução de Neil Gaiman, apresenta ao leitor o universo fantástico criado por Herbert e que será adaptado ao cinema por Denis Villeneuve, diretor de A chegada e de Blade Runner 2049.', 'Duna.jpg', 'Duna1.jpg'),
    ('Hobbit', 'J.R.R. Tolkien', '50,84', 'Fantasia', '336', 'Bilbo Bolseiro era um dos mais respeitáveis hobbits de todo o Condado até que, um dia, o mago Gandalf bate à sua porta. A partir de então, toda sua vida pacata e campestre soprando anéis de fumaça com seu belo cachimbo começa a mudar. Ele é convocado a participar de uma aventura por ninguém menos do que Thorin Escudo-de-Carvalho, um príncipe do poderoso povo dos Anãos.', 'Hobbit.jpg', 'Hobbit1.jpg'),
    ('O Jardim Secreto', 'Frances Hodgson Bernett', '19,44', 'Fantasia', '288', 'As histórias encantadoras e surpreendentes são capazes de tocar o coração de leitores de diferentes gerações. Em 1911, a autora Frances Hodgson Burnett escreveu O Jardim Secreto, uma obra sobre o poder transformador da amizade e da natureza. O enredo conta a história de Mary, uma menina rabugenta, irritada e desagradável; Dickon, um garoto doce e amigo que é encantador de animais; e Colin, um menino mimado e apavorado com uma possível iminência da morte. Lírico e apaixonante, O Jardim Secreto é um livro que fascina a todos com sua receita secreta para vencer obstáculos, superar desafios e encontrar um motivo para ser feliz. Mergulhe neste emocionante clássico da literatura infantojuvenil.', 'JardimSecreto.jpg', 'JardimSecreto1.jpg'),
    ('As Crônicas de Nárnia', 'C. S. Lewis', '49,00', 'Fantasia', '752', 'Viagens ao fim do mundo, criaturas fantásticas e batalhas épicas entre o bem e o mal - o que mais um leitor poderia querer de um livro? O livro que tem tudo isso é "O leão, a feiticeira e o guarda-roupa", escrito em 1949 por Clive Staples Lewis. MasLewis não parou por aí. Seis outros livros vieram depois e, juntos, ficaram conhecidos como "As crônicas de Nárnia".', 'Narnia.jpg', 'Narnia1.jpg'),
    ('O Filho de Netuno', 'Rick Riordan', '49.90', 'Fantasia', '432', 'Filho de Poseidon, o deus do mar, um belo dia Percy desperta sem memória e acaba em um acampamento de heróis que não reconhece. Agarrado à lembrança de uma garota, só tem uma certeza: os dias de jornadas e batalhas não terminaram. Percy e seus novos colegas semideuses vão enfrentar os misteriosos desígnios da Profecia dos Sete. Se falharem, as consequências, é claro, serão desastrosas.', 'OFilhoDeNetuno.jpg', 'OFilhoDeNetuno1.jpg'),
    ('Orgulho e Preconceito', 'Jane Austen', '47,90', 'Romance', '240', 'Orgulho e Preconceito é um dos mais aclamados romances da escritora inglesa Jane Austen. Publicado em 1813, revela como era a sociedade da época, quando os relacionamentos se desenrolavam de maneira mais lenta e romântica, no ritmo das cartas levadas por mensageiros a cavalo. Nesse mundo, o sonho da Sra. Bennet era casar bem suas cinco filhas: Jane, Elizabeth, Mary, Kitty e Lydia. Entre as irmãs, destaca-se Elizabeth, a Lizzy, que se depara com um turbilhão de sentimentos diante do orgulho e preconceito que mascaram a realidade. Trata-se de um clássico que, mesmo após duzentos anos desde a sua primeira publicação, continua a encantar milhões de leitores ao redor do mundo.', 'OrgulhoEPreconceito.jpg', 'OrgulhoEPreconceito1.jpg'),
    ('O Ultimo Olimpiano', 'Rick Riordan', '51,00', 'Fantasia', '384', 'Os meios-sangues passaram o ano inteiro preparando-se para a batalha contra os Titãs, e sabem que as chances de vitória são pequenas. O exército de Cronos está mais poderoso que nunca, e cada novo deus ou semideus que se une à causa confere mais força ao vingativo titã.', 'OUltimoOlimpiano.jpg', 'OUltimoOlimpiano1.jpg'),
    ('Silmarillion', 'J. R. R. Tolkien', '48,08', 'Fantasia', '592', '"O Silmarillion" é um relato dos Dias Antigos da Primeira Era do mundo criado por J.R.R. Tolkien. É a história longínqua para a qual os personagens de "O Senhor dos Anéis" e "O Hobbit" olham para trás, e em cujos eventos alguns deles, como Elrond e Galadriel, tomaram parte. Os contos de "O Silmarillion" se passam em uma época em que Morgoth, o Primeiro Senhor Sombrio, habitava a Terra-média, e os Altos-Elfos guerreavam contra ele pela recuperação das Silmarils, as joias que continham a pura luz de Valinor.', 'Silmarillion.jpg', 'Silmarillion1.jpg');

DROP TABLE IF EXISTS `comentarios`;

CREATE TABLE `comentarios` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `id_livro` INT,
    `comentario` TEXT,
    `nome` VARCHAR(50),
    `conta` VARCHAR(50),
    `data` DATETIME,
    FOREIGN KEY (`id_livro`) REFERENCES `livros`(`id`)
);

INSERT INTO `comentarios` (`id_livro`, `comentario`, `nome`, `conta`, `data`)
VALUES 
    (1, 'Adorei o livro! A história é fantástica.', 'João Silva', 'joao_silva@gmail.com', '2024-07-26 10:00:00'),
    (1, 'Uma leitura envolvente do início ao fim.', 'Maria Souza', 'maria_souza@gmail.com', '2024-07-26 11:00:00'),
    (2, 'Um clássico moderno. Recomendo!', 'Carlos Pereira', 'carlos_pereira@gmail.com', '2024-07-26 12:00:00');

DROP TABLE IF EXISTS `likes`;

CREATE TABLE `likes` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `id_livro` INT,
    `conta` VARCHAR(50),
    FOREIGN KEY (`id_livro`) REFERENCES `livros`(`id`)
);

INSERT INTO `likes` (`id_livro`, `conta`)
VALUES 
	(1,'fabricio.silva@gmail.com');
