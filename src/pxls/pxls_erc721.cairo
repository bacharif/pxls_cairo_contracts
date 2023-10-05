use starknet::ContractAddress;

#[starknet::interface]
trait PxlERC721Trait<TContractState> {
    fn supports_interface(self: @TContractState) -> felt252;
    fn name(self: @TContractState) -> felt252;
    fn symbol(self: @TContractState) -> felt252;
    fn balance_of(self: @TContractState, owner: felt252) -> u128;
    fn get_minted_count(self: @TContractState) -> u256;
    fn total_supply(self: @TContractState) -> u256;
    fn get_approved(self: @TContractState, token_id: u256) -> u256;
    fn is_approved_for_all(self: @TContractState, owner: felt252, operator: felt252) -> bool;
    fn contract_uri(self: @TContractState) -> felt252;
    fn token_uri(self: @TContractState, token_id: u256) -> felt252;
    fn matrix_size(self: @TContractState) -> u256;
    fn max_supply(self: @TContractState) -> u256;
    fn pxls_owned(self: @TContractState, owner: felt252) -> u256;
    fn owner(self: @TContractState) -> felt252; 
}

#[starknet::contract]
mod PxlERC721 {
    use pxls_contracts::pxls::pxls_erc721::PxlERC721Trait;
use starknet::{ContractAddress, get_caller_address};
    use openzeppelin::token::erc721::ERC721;
    use openzeppelin::access::ownable::Ownable;

    #[storage]
    struct Storage {
        name: felt252,
        symbol: felt252,
        minted_count: u256,
        matrix_size: u256,
        contract_uri_hash: LegacyMap::<u256, felt252>,
        pxls_1_100: ContractAddress,
        pxls_101_200: ContractAddress,
        pxls_201_300: ContractAddress,
        pxls_301_400: ContractAddress,
        original_pixel_erc721: ContractAddress
    }

    #[constructor]
    fn constructor(
        ref self: ContractState,
        proxy_admin: felt252,
        name: felt252,
        symbol: felt252,
        m_size: u256,
        owner: felt252,
        pxls_1_100_address: ContractAddress,
        pxls_101_200_address: ContractAddress,
        pxls_201_300_address: ContractAddress,
        pxls_301_400_address: ContractAddress,
        original_pixel_erc721_address: ContractAddress
    ) {
        //Proxy::initializer(proxy_admin);
        //ERC721::initializer(name, symbol);
        //Ownable::initializer(owner);

        self.matrix_size.write(m_size);
        self.pxls_1_100.write(pxls_1_100_address);
        self.pxls_101_200.write(pxls_101_200_address);
        self.pxls_201_300.write(pxls_201_300_address);
        self.pxls_301_400.write(pxls_301_400_address);
        self.original_pixel_erc721.write(original_pixel_erc721_address);
    }

    #[external(v0)]
    impl PxlERC721Impl of super::PxlERC721Trait<ContractState> {

        fn supports_interface(self: @ContractState) -> felt252 {
            return 0;
        }

        fn name(self: @ContractState) -> felt252 {
            return self.name.read();
        }

        fn symbol(self: @ContractState) -> felt252 {
            return self.symbol.read();
        }

        fn balance_of(self: @ContractState, owner: felt252) -> u128 {
            return 0;
        }

        fn get_approved(self: @ContractState, token_id: u256) -> u256 {
            return 0;
        }

        fn is_approved_for_all(self: @ContractState, owner: felt252, operator: felt252) -> bool {

            return false;
        }

        fn contract_uri(self: @ContractState) -> felt252 {
            return 0;
        }

        fn token_uri(self: @ContractState, token_id: u256) -> felt252 {
            return 0;
        }

        fn matrix_size(self: @ContractState) -> u256 {
            return self.matrix_size.read();
        }

        fn max_supply(self: @ContractState) -> u256 {
            return 0;
        }

        fn pxls_owned(self: @ContractState, owner: felt252) -> u256 {
            return 0;
        }

        fn owner(self: @ContractState) -> felt252 {
            return 0;
        }

        fn get_minted_count(self: @ContractState) -> u256 {
            return self.minted_count.read();
        }

        fn total_supply(self: @ContractState) -> u256 {
            return self.minted_count.read();
        }
    }

}