pub const InstanceRoleCredentialsProvider = enum {
    shared_credential_file,

    pub const json_field_names = .{
        .shared_credential_file = "SHARED_CREDENTIAL_FILE",
    };
};
