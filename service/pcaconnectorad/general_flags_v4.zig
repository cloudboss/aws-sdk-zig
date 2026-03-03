/// General flags for v4 template schema that defines if the template is for a
/// machine or a
/// user and if the template can be issued using autoenrollment.
pub const GeneralFlagsV4 = struct {
    /// Allows certificate issuance using autoenrollment. Set to TRUE to allow
    /// autoenrollment.
    auto_enrollment: ?bool = null,

    /// Defines if the template is for machines or users. Set to TRUE if the
    /// template is for
    /// machines. Set to FALSE if the template is for users
    machine_type: ?bool = null,

    pub const json_field_names = .{
        .auto_enrollment = "AutoEnrollment",
        .machine_type = "MachineType",
    };
};
