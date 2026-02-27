/// The Terraform s3 state file you need to import.
pub const TerraformSource = struct {
    /// The URL of the Terraform s3 state file you need to import.
    s_3_state_file_url: []const u8,

    pub const json_field_names = .{
        .s_3_state_file_url = "s3StateFileUrl",
    };
};
