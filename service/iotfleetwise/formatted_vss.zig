/// [Vehicle Signal Specification
/// (VSS)](https://www.w3.org/auto/wg/wiki/Vehicle_Signal_Specification_(VSS)/Vehicle_Data_Spec) is a precise language used to describe
/// and model signals in vehicle networks. The JSON file collects signal
/// specificiations in
/// a VSS format.
pub const FormattedVss = union(enum) {
    /// Provides the VSS in JSON format.
    vss_json: ?[]const u8,

    pub const json_field_names = .{
        .vss_json = "vssJson",
    };
};
