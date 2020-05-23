library(usethis)
library(hexSticker)

img <- file.path(getwd(),
    "man",
    "figures",
    "seaweed.svg"
)

hexSticker::sticker(
    img,
    s_x = 1,
    s_width = .5,
    s_height = .5,
    p_size = 16,
    package = "rjavacmecab",
    p_color = "#6265EE",
    h_size = 2.4,
    h_fill = "#FFFFFF",
    h_color = "#65EE62",
    filename = "man/figures/logo-origin.png"
)

use_logo("man/figures/logo-origin.png")

