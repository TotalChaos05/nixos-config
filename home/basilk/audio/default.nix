{pkgs, ...}: 
{
  home.packages = with pkgs; [
    lsp-plugins
    drumkv1
    geonkick
    x42-avldrums
    sooperlooper
    hydrogen
    samplebrain
    ninjas2
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
