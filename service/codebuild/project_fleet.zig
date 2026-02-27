/// Information about the compute fleet of the build project. For more
/// information, see [Working
/// with reserved capacity in
/// CodeBuild](https://docs.aws.amazon.com/codebuild/latest/userguide/fleets.html).
pub const ProjectFleet = struct {
    /// Specifies the compute fleet ARN for the build project.
    fleet_arn: ?[]const u8,

    pub const json_field_names = .{
        .fleet_arn = "fleetArn",
    };
};
