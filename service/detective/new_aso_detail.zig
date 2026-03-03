/// Details new Autonomous System Organizations (ASOs) used either at the
/// resource or account level.
pub const NewAsoDetail = struct {
    /// Details about the new Autonomous System Organization (ASO).
    aso: ?[]const u8 = null,

    /// Checks if the Autonomous System Organization (ASO) is new for the entire
    /// account.
    is_new_for_entire_account: bool = false,

    pub const json_field_names = .{
        .aso = "Aso",
        .is_new_for_entire_account = "IsNewForEntireAccount",
    };
};
