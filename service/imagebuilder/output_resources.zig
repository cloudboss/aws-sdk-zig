const Ami = @import("ami.zig").Ami;
const Container = @import("container.zig").Container;

/// The resources produced by this image.
pub const OutputResources = struct {
    /// The Amazon EC2 AMIs created by this image. The list contains one entry per
    /// AMI, including copies that distribution created in each target
    /// Amazon Web Services Region and account.
    amis: ?[]const Ami = null,

    /// The container images that Image Builder created when it built this image,
    /// stored in
    /// the output Amazon ECR repository.
    containers: ?[]const Container = null,

    pub const json_field_names = .{
        .amis = "amis",
        .containers = "containers",
    };
};
