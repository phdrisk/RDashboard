# RDhashboard
Painel de Controle de Dados em R

## BIBLIOTECAS NECESSÁRIAS
Library(Shiny)
Library(RMarkdown)

## INSTALAÇÃO

1º) Instalação do R<br />
$ sudo apt-get install r-base r-base-core

2º) Instalar o Rstudio <br>
https://www.rstudio.com/products/rstudio/download/#download -> RStudio 1.1.456 - Ubuntu 16.04+/Debian 9+ (64-bit)


3º) Instalação do pacote Shiny (importante que seja dessa forma) <br>

sudo su - -c "R -e \"install.packages('shiny', repos='http://cran.rstudio.com/')\""

4º) Instalação do Shiny-Server <br>
wget https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.5.5.872-amd64.deb
sudo gdebi shiny-server-1.5.5.872-amd64.deb

4º)

## PRINCIPAIS COMANDOS PARA INSTALAÇÃO
 - Parar/ Iniciar/ Restartar/Status servidor Shiny
$ sudo systemctl stop/start/restart/status shiny-server

## PRINCIPAIS COMANDOS

### Column {data-width=150}
  Similar ao frameset (html), cria uma coluna com x pixels

### ```{r}      ```  
  Estabelece o espaço (scope) dos comandos   

###  Entrada para Formularios

``` selctInput, sliderInput, fileInput, pickerInput ```

## LINKS
https://www.digitalocean.com/community/tutorials/how-to-set-up-shiny-server-on-ubuntu-16-04
http://docs.rstudio.com/shiny-server/#install-shiny

## EXEMPLOS



 
