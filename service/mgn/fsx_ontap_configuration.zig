/// FSx for ONTAP storage configuration.
pub const FsxOntapConfiguration = struct {
    /// FSx ONTAP configuration credentials secret ARN.
    credentials_secret_arn: []const u8,

    /// FSx ONTAP configuration storage virtual machine ID.
    storage_virtual_machine_id: []const u8,

    pub const json_field_names = .{
        .credentials_secret_arn = "credentialsSecretArn",
        .storage_virtual_machine_id = "storageVirtualMachineId",
    };
};
