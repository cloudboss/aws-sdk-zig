/// A regional account-level EVS setting, represented as a name and value pair.
pub const AccountSetting = struct {
    /// The name of the EVS setting. Valid values are:
    ///
    /// * `vcfPortedCoreCount` (type: numeric string) - The total number of VCF
    ///   license cores ported to Amazon EVS for the account in that Region. The
    ///   maximum value is 1,000,000 cores. This setting value is shared with
    ///   Broadcom for record-keeping.
    name: []const u8,

    /// The value of the EVS setting.
    value: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
