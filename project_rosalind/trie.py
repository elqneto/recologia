class Trie(object):
    def __init__(self):
        self.contagem = 1
        self.raiz = [self.contagem, {}]

    def inserir(self, sequencia):
        node = self.raiz
        for base in sequencia:
            if base not in node[1]:
                self.contagem = self.contagem +1
                node[1][base] = [self.contagem, {}]
            node = node[1][base]

    def imprime(self):
        print self.raiz

def formata_recursivo(node):
    for base, node2 in node[1].iteritems():
        print node[0], node2[0], base
        formata_recursivo(node2)

if __name__ == '__main__':
    entrada = open("trie.in").readlines()
    dados=[]

    for linha in entrada:
        dados.append(linha.strip())

    print dados

    trie_sequencias = Trie()

    for sequencia in dados:
        trie_sequencias.inserir(sequencia)

    trie_sequencias.imprime()

    formata_recursivo(trie_sequencias.raiz)

