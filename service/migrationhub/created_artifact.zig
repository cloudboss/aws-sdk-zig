/// An ARN of the AWS cloud resource target receiving the migration (e.g., AMI,
/// EC2
/// instance, RDS instance, etc.).
pub const CreatedArtifact = struct {
    /// A description that can be free-form text to record additional detail about
    /// the artifact
    /// for clarity or for later reference.
    description: ?[]const u8,

    /// An ARN that uniquely identifies the result of a migration task.
    name: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .name = "Name",
    };
};
