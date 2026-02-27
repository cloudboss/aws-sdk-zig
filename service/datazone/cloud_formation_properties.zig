/// Part of the provisioning properties of the environment blueprint.
pub const CloudFormationProperties = struct {
    /// The template URL of the cloud formation provisioning properties of the
    /// environment blueprint.
    template_url: []const u8,

    pub const json_field_names = .{
        .template_url = "templateUrl",
    };
};
