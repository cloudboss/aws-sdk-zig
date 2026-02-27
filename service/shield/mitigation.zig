/// The mitigation applied to a DDoS attack.
pub const Mitigation = struct {
    /// The name of the mitigation taken for this attack.
    mitigation_name: ?[]const u8,

    pub const json_field_names = .{
        .mitigation_name = "MitigationName",
    };
};
