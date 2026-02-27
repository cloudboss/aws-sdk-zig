const ComputeType = @import("compute_type.zig").ComputeType;
const DockerServerStatus = @import("docker_server_status.zig").DockerServerStatus;

/// Contains docker server information.
pub const DockerServer = struct {
    /// Information about the compute resources the docker server uses. Available
    /// values
    /// include:
    ///
    /// * `BUILD_GENERAL1_SMALL`: Use up to 4 GiB memory and 2 vCPUs for
    /// your docker server.
    ///
    /// * `BUILD_GENERAL1_MEDIUM`: Use up to 8 GiB memory and 4 vCPUs for
    /// your docker server.
    ///
    /// * `BUILD_GENERAL1_LARGE`: Use up to 16 GiB memory and 8 vCPUs for
    /// your docker server.
    ///
    /// * `BUILD_GENERAL1_XLARGE`: Use up to 64 GiB memory and 32 vCPUs for
    /// your docker server.
    ///
    /// * `BUILD_GENERAL1_2XLARGE`: Use up to 128 GiB memory and 64 vCPUs for
    /// your docker server.
    compute_type: ComputeType,

    /// A list of one or more security groups IDs.
    ///
    /// Security groups configured for Docker servers should allow ingress network
    /// traffic from the VPC configured in the project. They should allow ingress on
    /// port 9876.
    security_group_ids: ?[]const []const u8,

    /// A DockerServerStatus object to use for this docker server.
    status: ?DockerServerStatus,

    pub const json_field_names = .{
        .compute_type = "computeType",
        .security_group_ids = "securityGroupIds",
        .status = "status",
    };
};
