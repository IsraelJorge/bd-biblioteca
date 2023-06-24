-- CreateTable
CREATE TABLE `cliente` (
    `cpf` VARCHAR(191) NOT NULL,
    `nome_completo` VARCHAR(191) NOT NULL,
    `telefone` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `endereco` VARCHAR(191) NOT NULL,
    `status_cliente_id` INTEGER NOT NULL,

    UNIQUE INDEX `cliente_cpf_key`(`cpf`),
    UNIQUE INDEX `cliente_email_key`(`email`),
    PRIMARY KEY (`cpf`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `livro` (
    `isbn` VARCHAR(191) NOT NULL,
    `titulo` VARCHAR(191) NOT NULL,
    `numero_de_paginas` INTEGER NOT NULL,
    `ano_de_publicacao` DATETIME(3) NOT NULL,
    `categoria_id` INTEGER NOT NULL,
    `autor_id` INTEGER NOT NULL,
    `editora_issn` VARCHAR(191) NOT NULL,
    `status_livro_id` INTEGER NOT NULL,

    UNIQUE INDEX `livro_isbn_key`(`isbn`),
    PRIMARY KEY (`isbn`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `autor` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome_completo` VARCHAR(191) NOT NULL,
    `data_nascimento` DATETIME(3) NOT NULL,
    `descricao_do_autor` VARCHAR(191) NOT NULL,
    `nacionalidade` VARCHAR(191) NOT NULL,
    `editora_issn` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `editora` (
    `issn` VARCHAR(191) NOT NULL,
    `nome` VARCHAR(191) NOT NULL,
    `pais_de_origem` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `editora_issn_key`(`issn`),
    PRIMARY KEY (`issn`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `categoria` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome_categoria` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `categoria_nome_categoria_key`(`nome_categoria`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `multa` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `valor` DECIMAL(65, 30) NOT NULL,
    `status` BOOLEAN NOT NULL DEFAULT true,
    `data_de_vencimento` DATETIME(3) NOT NULL,
    `data_de_aplicacao` DATETIME(3) NOT NULL,
    `cliente_cpf` VARCHAR(191) NOT NULL,
    `emprestimo_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `emprestimo` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `data_de_emprestimo` DATETIME(3) NOT NULL,
    `data_de_devolucao` DATETIME(3) NOT NULL,
    `livro_isbn` VARCHAR(191) NOT NULL,
    `cliente_cpf` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `reserva` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `status` BOOLEAN NOT NULL DEFAULT true,
    `data_de_reserva` DATETIME(3) NOT NULL,
    `livro_isbn` VARCHAR(191) NOT NULL,
    `cliente_cpf` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `historico_cliente` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `cliente_cpf` VARCHAR(191) NOT NULL,
    `reserva_id` INTEGER NOT NULL,
    `emprestimo_id` INTEGER NOT NULL,
    `multa_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `historico_livro` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `cliente_cpf` VARCHAR(191) NOT NULL,
    `reserva_id` INTEGER NOT NULL,
    `emprestimo_id` INTEGER NOT NULL,
    `livro_isbn` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `status_cliente` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome_status` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `status_cliente_nome_status_key`(`nome_status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `status_livro` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome_status` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `status_livro_nome_status_key`(`nome_status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `cliente` ADD CONSTRAINT `cliente_status_cliente_id_fkey` FOREIGN KEY (`status_cliente_id`) REFERENCES `status_cliente`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `livro` ADD CONSTRAINT `livro_status_livro_id_fkey` FOREIGN KEY (`status_livro_id`) REFERENCES `status_livro`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `livro` ADD CONSTRAINT `livro_editora_issn_fkey` FOREIGN KEY (`editora_issn`) REFERENCES `editora`(`issn`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `livro` ADD CONSTRAINT `livro_autor_id_fkey` FOREIGN KEY (`autor_id`) REFERENCES `autor`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `livro` ADD CONSTRAINT `livro_categoria_id_fkey` FOREIGN KEY (`categoria_id`) REFERENCES `categoria`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `autor` ADD CONSTRAINT `autor_editora_issn_fkey` FOREIGN KEY (`editora_issn`) REFERENCES `editora`(`issn`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `multa` ADD CONSTRAINT `multa_emprestimo_id_fkey` FOREIGN KEY (`emprestimo_id`) REFERENCES `emprestimo`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `multa` ADD CONSTRAINT `multa_cliente_cpf_fkey` FOREIGN KEY (`cliente_cpf`) REFERENCES `cliente`(`cpf`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `emprestimo` ADD CONSTRAINT `emprestimo_livro_isbn_fkey` FOREIGN KEY (`livro_isbn`) REFERENCES `livro`(`isbn`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `emprestimo` ADD CONSTRAINT `emprestimo_cliente_cpf_fkey` FOREIGN KEY (`cliente_cpf`) REFERENCES `cliente`(`cpf`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `reserva` ADD CONSTRAINT `reserva_livro_isbn_fkey` FOREIGN KEY (`livro_isbn`) REFERENCES `livro`(`isbn`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `reserva` ADD CONSTRAINT `reserva_cliente_cpf_fkey` FOREIGN KEY (`cliente_cpf`) REFERENCES `cliente`(`cpf`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `historico_cliente` ADD CONSTRAINT `historico_cliente_multa_id_fkey` FOREIGN KEY (`multa_id`) REFERENCES `multa`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `historico_cliente` ADD CONSTRAINT `historico_cliente_emprestimo_id_fkey` FOREIGN KEY (`emprestimo_id`) REFERENCES `emprestimo`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `historico_cliente` ADD CONSTRAINT `historico_cliente_reserva_id_fkey` FOREIGN KEY (`reserva_id`) REFERENCES `reserva`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `historico_cliente` ADD CONSTRAINT `historico_cliente_cliente_cpf_fkey` FOREIGN KEY (`cliente_cpf`) REFERENCES `cliente`(`cpf`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `historico_livro` ADD CONSTRAINT `historico_livro_emprestimo_id_fkey` FOREIGN KEY (`emprestimo_id`) REFERENCES `emprestimo`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `historico_livro` ADD CONSTRAINT `historico_livro_reserva_id_fkey` FOREIGN KEY (`reserva_id`) REFERENCES `reserva`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `historico_livro` ADD CONSTRAINT `historico_livro_cliente_cpf_fkey` FOREIGN KEY (`cliente_cpf`) REFERENCES `cliente`(`cpf`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `historico_livro` ADD CONSTRAINT `historico_livro_livro_isbn_fkey` FOREIGN KEY (`livro_isbn`) REFERENCES `livro`(`isbn`) ON DELETE RESTRICT ON UPDATE CASCADE;
