const Ami = @import("ami.zig").Ami;
const Container = @import("container.zig").Container;

/// The resources produced by this image.
pub const OutputResources = struct {
    /// The Amazon EC2 AMIs created by this image.
    amis: ?[]const Ami = null,

    /// Container images that the pipeline has generated and stored in the output
    /// repository.
    containers: ?[]const Container = null,

    pub const json_field_names = .{
        .amis = "amis",
        .containers = "containers",
    };
};
