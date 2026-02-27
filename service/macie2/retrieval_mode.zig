/// The access method to use when retrieving occurrences of sensitive data
/// reported by findings. Valid values are:
pub const RetrievalMode = enum {
    caller_credentials,
    assume_role,

    pub const json_field_names = .{
        .caller_credentials = "CALLER_CREDENTIALS",
        .assume_role = "ASSUME_ROLE",
    };
};
