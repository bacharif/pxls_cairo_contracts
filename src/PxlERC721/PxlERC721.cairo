use starknet::ContractAddress;

#[starknet::interface]
trait PxlERC721Trait<TContractState> {
    fn supports_interface(self: TContractState) -> felt252;
    fn name(self: TContractState) -> felt252;
    fn symbol(self: TContractState) -> felt252;
    fn balance_of(self: TContractState, owner: felt) -> u128;
    fn get_minted_count(self: TContractState) -> Uint256;
    fn total_supply(self: TContractState) -> u256;
    fn get_approved(self: TContractState, token_id: u256) -> u256;
    fn is_approved_for_all(self: TContractState, owner: felt252, operator: felt252) -> bool;
    fn contract_uri(self: TContractState) -> felt252;
    fn token_uri(self: TContractState, token_id: u256) -> felt252;
    fn matrix_size(self: TContractState) -> u256;
    fn max_supply(self: TContractState) -> u256;
    fn pxls_owned(self: TContractState, owner: felt252) -> u256;
    fn owner(self: TContractState) -> felt252; 
}

#[starknet::contract]
mod PxlERC721 {
    use starknet::{get_caller_address};
    use openzeppelin::contracts::{ERC721, Ownable, Proxy};

    #[storage]
    struct Storage {
        minted_count: Uint256,
        matrix_size: Uint256,
        contract_uri_hash: LegacyMap::<u256, felt>,
        pxls_1_100: ContractAddress,
        pxls_101_200: ContractAddress,
        pxls_201_300: ContractAddress,
        pxls_301_400: ContractAddress,
        original_pixel_erc721: ContractAddress
    }

    #[constructor]
    fn constructor(
        ref self: Storage,
        proxy_admin: felt,
        name: felt,
        symbol: felt,
        m_size: Uint256,
        owner: felt,
        pxls_1_100_address: ContractAddress,
        pxls_101_200_address: ContractAddress,
        pxls_201_300_address: ContractAddress,
        pxls_301_400_address: ContractAddress,
        original_pixel_erc721_address: ContractAddress
    ) {
        Proxy::initializer(proxy_admin);
        ERC721::initializer(name, symbol);
        Ownable::initializer(owner);

        self.matrix_size.write(m_size);
        self.pxls_1_100.write(pxls_1_100_address);
        self.pxls_101_200.write(pxls_101_200_address);
        self.pxls_201_300.write(pxls_201_300_address);
        self.pxls_301_400.write(pxls_301_400_address);
        self.original_pixel_erc721.write(original_pixel_erc721_address);
    }

    #[external(v0)]
    impl PxlERC721Impl of super::PxlERC721Trait<Storage> {
        fn get_minted_count(self: @Storage) -> Uint256 {
            self.minted_count.read()
        }

        fn total_supply(self: @Storage) -> Uint256 {
            self.minted_count.read()
        }

    }

    #[generate_trait]
    impl InternalImpl of InternalTrait {
        fn _some_internal_function(ref self: Storage) {
        }
    }
}
