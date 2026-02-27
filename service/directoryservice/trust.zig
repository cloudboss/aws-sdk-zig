const SelectiveAuth = @import("selective_auth.zig").SelectiveAuth;
const TrustDirection = @import("trust_direction.zig").TrustDirection;
const TrustState = @import("trust_state.zig").TrustState;
const TrustType = @import("trust_type.zig").TrustType;

/// Describes a trust relationship between an Managed Microsoft AD directory and
/// an external
/// domain.
pub const Trust = struct {
    /// The date and time that the trust relationship was created.
    created_date_time: ?i64,

    /// The Directory ID of the Amazon Web Services directory involved in the trust
    /// relationship.
    directory_id: ?[]const u8,

    /// The date and time that the trust relationship was last updated.
    last_updated_date_time: ?i64,

    /// The Fully Qualified Domain Name (FQDN) of the external domain involved in
    /// the trust
    /// relationship.
    remote_domain_name: ?[]const u8,

    /// Current state of selective authentication for the trust.
    selective_auth: ?SelectiveAuth,

    /// The date and time that the TrustState was last updated.
    state_last_updated_date_time: ?i64,

    /// The trust relationship direction.
    trust_direction: ?TrustDirection,

    /// The unique ID of the trust relationship.
    trust_id: ?[]const u8,

    /// The trust relationship state.
    trust_state: ?TrustState,

    /// The reason for the TrustState.
    trust_state_reason: ?[]const u8,

    /// The trust relationship type. `Forest` is the default.
    trust_type: ?TrustType,

    pub const json_field_names = .{
        .created_date_time = "CreatedDateTime",
        .directory_id = "DirectoryId",
        .last_updated_date_time = "LastUpdatedDateTime",
        .remote_domain_name = "RemoteDomainName",
        .selective_auth = "SelectiveAuth",
        .state_last_updated_date_time = "StateLastUpdatedDateTime",
        .trust_direction = "TrustDirection",
        .trust_id = "TrustId",
        .trust_state = "TrustState",
        .trust_state_reason = "TrustStateReason",
        .trust_type = "TrustType",
    };
};
