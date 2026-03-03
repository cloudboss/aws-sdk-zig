const aws = @import("aws");
const std = @import("std");

const batch_get_token_balance = @import("batch_get_token_balance.zig");
const get_asset_contract = @import("get_asset_contract.zig");
const get_token_balance = @import("get_token_balance.zig");
const get_transaction = @import("get_transaction.zig");
const list_asset_contracts = @import("list_asset_contracts.zig");
const list_filtered_transaction_events = @import("list_filtered_transaction_events.zig");
const list_token_balances = @import("list_token_balances.zig");
const list_transaction_events = @import("list_transaction_events.zig");
const list_transactions = @import("list_transactions.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "ManagedBlockchain Query";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Gets the token balance for a batch of tokens by using the
    /// `BatchGetTokenBalance`
    /// action for every token in the request.
    ///
    /// Only the native tokens BTC and ETH, and the ERC-20,
    /// ERC-721, and ERC 1155 token standards are supported.
    pub fn batchGetTokenBalance(self: *Self, allocator: std.mem.Allocator, input: batch_get_token_balance.BatchGetTokenBalanceInput, options: batch_get_token_balance.Options) !batch_get_token_balance.BatchGetTokenBalanceOutput {
        return batch_get_token_balance.execute(self, allocator, input, options);
    }

    /// Gets the information about a specific contract deployed on the blockchain.
    ///
    /// * The Bitcoin blockchain networks do not support this
    /// operation.
    ///
    /// * Metadata is currently only available for some `ERC-20` contracts.
    /// Metadata will be available for additional contracts in the future.
    pub fn getAssetContract(self: *Self, allocator: std.mem.Allocator, input: get_asset_contract.GetAssetContractInput, options: get_asset_contract.Options) !get_asset_contract.GetAssetContractOutput {
        return get_asset_contract.execute(self, allocator, input, options);
    }

    /// Gets the balance of a specific token, including native tokens, for a given
    /// address (wallet or contract) on the blockchain.
    ///
    /// Only the native tokens BTC and ETH, and the ERC-20,
    /// ERC-721, and ERC 1155 token standards are supported.
    pub fn getTokenBalance(self: *Self, allocator: std.mem.Allocator, input: get_token_balance.GetTokenBalanceInput, options: get_token_balance.Options) !get_token_balance.GetTokenBalanceOutput {
        return get_token_balance.execute(self, allocator, input, options);
    }

    /// Gets the details of a transaction.
    ///
    /// This action will return transaction details for all transactions
    /// that are *confirmed* on the blockchain, even if they have not reached
    /// [finality](https://docs.aws.amazon.com/managed-blockchain/latest/ambq-dg/key-concepts.html#finality).
    pub fn getTransaction(self: *Self, allocator: std.mem.Allocator, input: get_transaction.GetTransactionInput, options: get_transaction.Options) !get_transaction.GetTransactionOutput {
        return get_transaction.execute(self, allocator, input, options);
    }

    /// Lists all the contracts for a given contract type deployed by an address
    /// (either a contract address or a wallet address).
    ///
    /// The Bitcoin blockchain networks do not support this
    /// operation.
    pub fn listAssetContracts(self: *Self, allocator: std.mem.Allocator, input: list_asset_contracts.ListAssetContractsInput, options: list_asset_contracts.Options) !list_asset_contracts.ListAssetContractsOutput {
        return list_asset_contracts.execute(self, allocator, input, options);
    }

    /// Lists all the transaction events for an address on the blockchain.
    ///
    /// This operation is only supported on the Bitcoin networks.
    pub fn listFilteredTransactionEvents(self: *Self, allocator: std.mem.Allocator, input: list_filtered_transaction_events.ListFilteredTransactionEventsInput, options: list_filtered_transaction_events.Options) !list_filtered_transaction_events.ListFilteredTransactionEventsOutput {
        return list_filtered_transaction_events.execute(self, allocator, input, options);
    }

    /// This action returns the following for a given blockchain network:
    ///
    /// * Lists all token balances owned by an address (either a contract
    /// address or a wallet address).
    ///
    /// * Lists all token balances for all tokens created by a contract.
    ///
    /// * Lists all token balances for a given token.
    ///
    /// You must always specify the network property of
    /// the `tokenFilter` when using this operation.
    pub fn listTokenBalances(self: *Self, allocator: std.mem.Allocator, input: list_token_balances.ListTokenBalancesInput, options: list_token_balances.Options) !list_token_balances.ListTokenBalancesOutput {
        return list_token_balances.execute(self, allocator, input, options);
    }

    /// Lists all the transaction events for a transaction
    ///
    /// This action will return transaction details for all transactions
    /// that are *confirmed* on the blockchain, even if they have not reached
    /// [finality](https://docs.aws.amazon.com/managed-blockchain/latest/ambq-dg/key-concepts.html#finality).
    pub fn listTransactionEvents(self: *Self, allocator: std.mem.Allocator, input: list_transaction_events.ListTransactionEventsInput, options: list_transaction_events.Options) !list_transaction_events.ListTransactionEventsOutput {
        return list_transaction_events.execute(self, allocator, input, options);
    }

    /// Lists all the transaction events for a transaction.
    pub fn listTransactions(self: *Self, allocator: std.mem.Allocator, input: list_transactions.ListTransactionsInput, options: list_transactions.Options) !list_transactions.ListTransactionsOutput {
        return list_transactions.execute(self, allocator, input, options);
    }

    pub fn listAssetContractsPaginator(self: *Self, params: list_asset_contracts.ListAssetContractsInput) paginator.ListAssetContractsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFilteredTransactionEventsPaginator(self: *Self, params: list_filtered_transaction_events.ListFilteredTransactionEventsInput) paginator.ListFilteredTransactionEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTokenBalancesPaginator(self: *Self, params: list_token_balances.ListTokenBalancesInput) paginator.ListTokenBalancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTransactionEventsPaginator(self: *Self, params: list_transaction_events.ListTransactionEventsInput) paginator.ListTransactionEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTransactionsPaginator(self: *Self, params: list_transactions.ListTransactionsInput) paginator.ListTransactionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
