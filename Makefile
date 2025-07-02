-include .env

CCNFT_CONTRACT_ADDRESS := 0x46A4F2132D6BFBdD616849Cb50f642f107692B17
BUSD_CONTRACT_ADDRESS := 0xe4Ca44801a841B520379a777310efF4FE28110ea

PRIVATE_KEY := ${PRIVATE_KEY}
RPC_URL := ${RPC_URL}

NETWORK_ARGS := --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY) --broadcast
NETWORK_ARGS_VERIFY := --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify -vvvv --etherscan-api-key $(ETHERSCAN_API_KEY)

deployAndVerifyCCNft:
	@forge script script/DeployCCNFT.s.sol:DeployCCNFT $(NETWORK_ARGS_VERIFY)

deployAndVerifyBUSD:
	@forge script script/DeployBUSD.s.sol:DeployBUSD $(NETWORK_ARGS_VERIFY)

initializeCCNft:
	@forge script script/InitializeCCNFT.s.sol:InitializeCCNFT $(NETWORK_ARGS)


