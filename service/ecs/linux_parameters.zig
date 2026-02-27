const KernelCapabilities = @import("kernel_capabilities.zig").KernelCapabilities;
const Device = @import("device.zig").Device;
const Tmpfs = @import("tmpfs.zig").Tmpfs;

/// The Linux-specific options that are applied to the container, such as Linux
/// [KernelCapabilities](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_KernelCapabilities.html).
pub const LinuxParameters = struct {
    /// The Linux capabilities for the container that are added to or dropped from
    /// the default
    /// configuration provided by Docker.
    ///
    /// For tasks that use the Fargate launch type, `capabilities` is supported
    /// for all platform versions but the `add` parameter is only supported if
    /// using platform version 1.4.0 or later.
    capabilities: ?KernelCapabilities,

    /// Any host devices to expose to the container. This parameter maps to
    /// `Devices` in the docker container create command and the
    /// `--device` option to docker run.
    ///
    /// If you're using tasks that use the Fargate launch type, the `devices`
    /// parameter isn't supported.
    devices: ?[]const Device,

    /// Run an `init` process inside the container that forwards signals and reaps
    /// processes. This parameter maps to the `--init` option to docker run. This
    /// parameter requires version 1.25 of the Docker Remote API or greater on your
    /// container
    /// instance. To check the Docker Remote API version on your container instance,
    /// log in to
    /// your container instance and run the following command: `sudo docker version
    /// --format '{{.Server.APIVersion}}'`
    init_process_enabled: ?bool,

    /// The total amount of swap memory (in MiB) a container can use. This parameter
    /// will be
    /// translated to the `--memory-swap` option to docker run where the value would
    /// be the sum of the container memory plus the `maxSwap` value.
    ///
    /// If a `maxSwap` value of `0` is specified, the container will not
    /// use swap. Accepted values are `0` or any positive integer. If the
    /// `maxSwap` parameter is omitted, the container will use the swap
    /// configuration for the container instance it is running on. A `maxSwap` value
    /// must be set for the `swappiness` parameter to be used.
    ///
    /// If you're using tasks that use the Fargate launch type, the `maxSwap`
    /// parameter isn't supported.
    ///
    /// If you're using tasks on Amazon Linux 2023 the `swappiness` parameter
    /// isn't supported.
    max_swap: ?i32,

    /// The value for the size (in MiB) of the `/dev/shm` volume. This parameter
    /// maps to the `--shm-size` option to docker run.
    ///
    /// If you are using tasks that use the Fargate launch type, the
    /// `sharedMemorySize` parameter is not supported.
    shared_memory_size: ?i32,

    /// This allows you to tune a container's memory swappiness behavior. A
    /// `swappiness` value of `0` will cause swapping to not happen
    /// unless absolutely necessary. A `swappiness` value of `100` will
    /// cause pages to be swapped very aggressively. Accepted values are whole
    /// numbers between
    /// `0` and `100`. If the `swappiness` parameter is not
    /// specified, a default value of `60` is used. If a value is not specified for
    /// `maxSwap` then this parameter is ignored. This parameter maps to the
    /// `--memory-swappiness` option to docker run.
    ///
    /// If you're using tasks that use the Fargate launch type, the
    /// `swappiness` parameter isn't supported.
    ///
    /// If you're using tasks on Amazon Linux 2023 the `swappiness` parameter
    /// isn't supported.
    swappiness: ?i32,

    /// The container path, mount options, and size (in MiB) of the tmpfs mount.
    /// This
    /// parameter maps to the `--tmpfs` option to docker run.
    ///
    /// If you're using tasks that use the Fargate launch type, the `tmpfs`
    /// parameter isn't supported.
    tmpfs: ?[]const Tmpfs,

    pub const json_field_names = .{
        .capabilities = "capabilities",
        .devices = "devices",
        .init_process_enabled = "initProcessEnabled",
        .max_swap = "maxSwap",
        .shared_memory_size = "sharedMemorySize",
        .swappiness = "swappiness",
        .tmpfs = "tmpfs",
    };
};
