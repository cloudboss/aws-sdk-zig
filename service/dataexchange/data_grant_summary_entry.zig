const DataGrantAcceptanceState = @import("data_grant_acceptance_state.zig").DataGrantAcceptanceState;

/// Information about a data grant.
pub const DataGrantSummaryEntry = struct {
    /// The acceptance state of the data grant.
    acceptance_state: DataGrantAcceptanceState,

    /// The timestamp of when the data grant was accepted.
    accepted_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the data grant.
    arn: []const u8,

    /// The timestamp of when the data grant was created.
    created_at: i64,

    /// The ID of the data set associated to the data grant.
    data_set_id: []const u8,

    /// The timestamp of when access to the associated data set ends.
    ends_at: ?i64 = null,

    /// The ID of the data grant.
    id: []const u8,

    /// The name of the data grant.
    name: []const u8,

    /// The Amazon Web Services account ID of the data grant receiver.
    receiver_principal: []const u8,

    /// The Amazon Web Services account ID of the data grant sender.
    sender_principal: []const u8,

    /// The ID of the data set used to create the data grant.
    source_data_set_id: []const u8,

    /// The timestamp of when the data grant was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .acceptance_state = "AcceptanceState",
        .accepted_at = "AcceptedAt",
        .arn = "Arn",
        .created_at = "CreatedAt",
        .data_set_id = "DataSetId",
        .ends_at = "EndsAt",
        .id = "Id",
        .name = "Name",
        .receiver_principal = "ReceiverPrincipal",
        .sender_principal = "SenderPrincipal",
        .source_data_set_id = "SourceDataSetId",
        .updated_at = "UpdatedAt",
    };
};
