/// Selects method of inserting SDT information into output stream. "Follow
/// input SDT" copies SDT information from input stream to output stream.
/// "Follow input SDT if present" copies SDT information from input stream to
/// output stream if SDT information is present in the input, otherwise it will
/// fall back on the user-defined values. Enter "SDT Manually" means user will
/// enter the SDT information. "No SDT" means output stream will not contain SDT
/// information.
pub const OutputSdt = enum {
    sdt_follow,
    sdt_follow_if_present,
    sdt_manual,
    sdt_none,

    pub const json_field_names = .{
        .sdt_follow = "SDT_FOLLOW",
        .sdt_follow_if_present = "SDT_FOLLOW_IF_PRESENT",
        .sdt_manual = "SDT_MANUAL",
        .sdt_none = "SDT_NONE",
    };
};
