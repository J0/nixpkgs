{ lib
, pythonOlder
, buildPythonPackage
, fetchPypi
, betamax
, pytest
, betamax-matchers
, unittest2
, mock
, requests
, uritemplate
, python-dateutil
, jwcrypto
, pyopenssl
, ndg-httpsclient
, pyasn1
}:

buildPythonPackage rec {
  pname = "github3.py";
  version = "3.2.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-Cbcr4Ul9NGsJaM3oNgoNavedwgbQFJpjzT7IbGXDd8w=";
  };

  checkInputs = [ betamax pytest betamax-matchers ]
    ++ lib.optional (pythonOlder "3") unittest2
    ++ lib.optional (pythonOlder "3.3") mock;
  propagatedBuildInputs = [ requests uritemplate python-dateutil jwcrypto pyopenssl ndg-httpsclient pyasn1 ];

  postPatch = ''
    sed -i -e 's/unittest2 ==0.5.1/unittest2>=0.5.1/' setup.py
  '';

  # TODO: only disable the tests that require network
  doCheck = false;

  meta = with lib; {
    homepage = "https://github3py.readthedocs.org/en/master/";
    description = "A wrapper for the GitHub API written in python";
    license = licenses.bsd3;
    maintainers = with maintainers; [ pSub ];
  };

}
