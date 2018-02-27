library(tidyverse)

rint <- function(i){
  sample(i, 1)
}

lorem <- "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eget interdum purus. Curabitur porttitor, enim vitae convallis sollicitudin, tortor orci laoreet justo, et hendrerit neque velit et felis. Vivamus at dui sem. Quisque aliquam maximus pretium. Donec nec lectus blandit, sagittis mi facilisis, aliquam tellus. Pellentesque ac enim nec erat posuere semper. Proin vel sodales massa. Sed condimentum aliquam odio non placerat. Proin et nisi sapien. Vestibulum mattis magna ut quam rutrum, lobortis vestibulum lectus molestie. Suspendisse elementum eget eros vitae porta. In nec arcu auctor, congue ex tincidunt, dapibus nibh. Praesent ante mi, maximus eget augue eu, dapibus vehicula nibh. Vivamus hendrerit consectetur turpis at luctus. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
  
  Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nam sit amet purus lobortis, feugiat ante ut, semper libero. Donec vitae lacinia orci, vel finibus enim. Nullam consequat sem vel arcu eleifend maximus. Donec tristique nisl sed velit mollis egestas. Duis dapibus id tortor sit amet venenatis. Nulla pulvinar felis in vulputate facilisis. Cras convallis odio vel sagittis maximus. Morbi augue mauris, aliquet ut massa sit amet, dictum dictum ex. Nullam ullamcorper aliquam consectetur. Aliquam nec dictum risus. Aliquam egestas dignissim dolor id volutpat. Sed pharetra tortor vel purus varius varius.
  
  Fusce aliquet nulla erat, quis pharetra orci luctus sit amet. Morbi condimentum a libero eu pretium. Cras in aliquam enim. Integer molestie vitae purus a malesuada. Aliquam blandit eget quam a posuere. Sed a mauris vitae elit pulvinar semper non sagittis velit. Aliquam dictum fermentum augue. Curabitur sed dui eu lacus lobortis vehicula sodales eget lacus. Pellentesque eu pretium nibh, et egestas arcu. Nam convallis commodo leo a pharetra. Duis rhoncus risus non bibendum dignissim. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Morbi tristique consequat enim in eleifend. Curabitur dictum vulputate erat. Proin eget ornare tortor.
  
  Curabitur eget luctus sem. Etiam vel magna nibh. Donec cursus velit eget massa dignissim, sit amet varius risus porta. Duis at est sed lacus laoreet dictum. Nullam efficitur non orci nec rhoncus. Phasellus odio quam, iaculis pellentesque feugiat et, elementum mollis nulla. Integer pulvinar tincidunt ex quis lacinia. Fusce odio ligula, sagittis eu ex eget, rhoncus maximus neque. Curabitur venenatis erat in lacus facilisis varius. Ut vel mattis quam, sed rhoncus orci.
  
  Morbi quis laoreet erat. Fusce porttitor scelerisque accumsan. Phasellus ac ipsum dui. Maecenas commodo nec ligula vel tincidunt. Phasellus a blandit orci, id commodo ipsum. Etiam eget ligula congue, sollicitudin lacus vitae, sagittis ex. Praesent egestas ac mi et mattis. Nullam vitae odio at felis facilisis molestie ut at ex. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin laoreet convallis diam, sed faucibus tortor dignissim sed. Etiam eu blandit quam. Sed nisl ante, aliquam eget pellentesque quis, mattis id augue. Praesent facilisis, justo at elementum mattis, neque orci varius mi, eu egestas leo mauris ac velit. Integer ut risus eget nisi varius vestibulum."


number_gen <- function(){
  for (i in 1:3) { 
    numbers <- sample(50, 300, replace = TRUE)
    print(cat(numbers))
  }
  
  lorem_vec <- stringi::stri_split(lorem, regex = " ") %>% unlist()
  offset <- 0
  for (i in sample(length(lorem_vec), 100)) {
    lorem_vec <- append(lorem_vec, sample(1:15, 1), i+offset)
    offset <- offset + 1
  }
  cat(lorem_vec)
}

file_name_gen <- function(){
  lorem <- stringi::stri_replace_all_regex(lorem, '[^A-Za-z ]', '')
  lorem_vec <- stringi::stri_split(lorem, regex = " ") %>% unlist()
  seperators <- c('-','_')
  file_extensions <- c('tmp', 'txt', 'md', 'Rmd', 'png', 'docx', 'R')
  file_names <- character()
  for (i in 1:100){
    file_names <- append(file_names, 
                         paste0(
                           paste(sample(lorem_vec, rint(3)), collapse = sample(seperators, 1)),
                           '.',
                           paste(sample(file_extensions, rint(2)), collapse = '.')
                         )
    )
  }
  cat(file_names)
}