const ProtectedJobMemberOutputConfigurationInput = @import("protected_job_member_output_configuration_input.zig").ProtectedJobMemberOutputConfigurationInput;

/// The protected job output configuration input.
pub const ProtectedJobOutputConfigurationInput = union(enum) {
    /// The member of the protected job output configuration input.
    member: ?ProtectedJobMemberOutputConfigurationInput,

    pub const json_field_names = .{
        .member = "member",
    };
};
