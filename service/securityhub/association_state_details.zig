/// Describes the state of an association between a route table and a subnet or
/// gateway.
pub const AssociationStateDetails = struct {
    /// The state of the association.
    state: ?[]const u8,

    /// The status message, if applicable.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .state = "State",
        .status_message = "StatusMessage",
    };
};
