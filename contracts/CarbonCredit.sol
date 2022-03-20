pragma solidity 0.8.7;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CarbonCredit is ERC20, Ownable {
    string[] public carbonCertificates;
    mapping(string => uint256) public carbonCertificateValue;

    event DepositCarbonCreditsFromCertificate(
        address indexed approvedBy,
        uint256 indexed value,
        string ifpsHashOfCarbonCreditCertificate
    );
    token = await CarbonCredit.new("Uchains", "cCH")
    constructor(string memory _name, string memory _symbol)
        ERC20(_name, _symbol)
    {}

    function depositCarbonCreditsFromCertificate(
        uint256 _value,
        string memory _ipfsHashOfCarbonCreditCertificate
    ) public onlyOwner {
        require(_value > 0, "Certificate must have a value greater than 0");
        require(
            carbonCertificateValue[_ipfsHashOfCarbonCreditCertificate] == 0,
            "Certificate already deposited"
        );
        carbonCertificates.push(_ipfsHashOfCarbonCreditCertificate);
        carbonCertificateValue[_ipfsHashOfCarbonCreditCertificate] = _value;
        _mint(owner(), _value);
        emit DepositCarbonCreditsFromCertificate(
            owner(),
            _value,
            _ipfsHashOfCarbonCreditCertificate
        );
    }

    function retire(uint256 _value) public {
        _burn(msg.sender, _value);
    }

    function carbonCertificatesLength() public view returns (uint256 length) {
        return carbonCertificates.length;
    }
}
