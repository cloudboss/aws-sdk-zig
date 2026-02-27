/// Information about the call disconnect experience.
pub const DisconnectDetails = struct {
    /// Indicates the potential disconnection issues for a call. This field is not
    /// populated if the service does not
    /// detect potential issues.
    potential_disconnect_issue: ?[]const u8,

    pub const json_field_names = .{
        .potential_disconnect_issue = "PotentialDisconnectIssue",
    };
};
