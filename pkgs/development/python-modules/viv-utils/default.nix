{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  funcy,
  intervaltree,
  pefile,
  typing-extensions,
  vivisect,
  pytest-sugar,
  pytestCheckHook,
  python-flirt,
}:
buildPythonPackage rec {
  pname = "viv-utils";
  version = "0.7.11";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "williballenthin";
    repo = "viv-utils";
    rev = "refs/tags/v${version}";
    hash = "sha256-zYamhG5oeoYYVLEvv1EdZ1buFDByZatuCxbl0uRhk6Y=";
  };

  postPatch = ''
    substituteInPlace setup.py \
      --replace "==" ">="
  '';

  propagatedBuildInputs = [
    funcy
    intervaltree
    pefile
    typing-extensions
    vivisect
  ];

  nativeCheckInputs = [
    pytest-sugar
    pytestCheckHook
  ];

  passthru = {
    optional-dependencies = {
      flirt = [ python-flirt ];
    };
  };

  meta = with lib; {
    description = "Utilities for working with vivisect";
    homepage = "https://github.com/williballenthin/viv-utils";
    changelog = "https://github.com/williballenthin/viv-utils/releases/tag/v${version}";
    license = licenses.asl20;
    maintainers = [ ];
  };
}
