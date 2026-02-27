const ResourceState = @import("resource_state.zig").ResourceState;
const State = @import("state.zig").State;

/// An object with details the status of an Amazon Web Services account within
/// your Amazon Inspector
/// environment.
pub const AccountState = struct {
    /// The Amazon Web Services account ID.
    account_id: []const u8,

    /// An object detailing which resources Amazon Inspector is enabled to scan for
    /// the account.
    resource_state: ResourceState,

    /// An object detailing the status of Amazon Inspector for the account.
    state: State,

    pub const json_field_names = .{
        .account_id = "accountId",
        .resource_state = "resourceState",
        .state = "state",
    };
};
