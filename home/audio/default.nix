{pkgs, ...}: 
{
  home.packages = with pkgs; []
    lsp-plugins
    airwindows-lv2
    rkrlv2
    mda_lv2
    x42-plugins
    tunefish
    noise-repellent
    mod-distortion
    drumgizmo
    infamousPlugins
    distrho
    bshapr
    bchoppr
    talentedhack
    reaper
  ];
}
