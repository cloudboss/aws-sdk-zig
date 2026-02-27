pub const EnvironmentType = enum {
    windows_container,
    linux_container,
    linux_gpu_container,
    arm_container,
    windows_server_2019_container,
    windows_server_2022_container,
    linux_lambda_container,
    arm_lambda_container,
    linux_ec2,
    arm_ec2,
    windows_ec2,
    mac_arm,

    pub const json_field_names = .{
        .windows_container = "WINDOWS_CONTAINER",
        .linux_container = "LINUX_CONTAINER",
        .linux_gpu_container = "LINUX_GPU_CONTAINER",
        .arm_container = "ARM_CONTAINER",
        .windows_server_2019_container = "WINDOWS_SERVER_2019_CONTAINER",
        .windows_server_2022_container = "WINDOWS_SERVER_2022_CONTAINER",
        .linux_lambda_container = "LINUX_LAMBDA_CONTAINER",
        .arm_lambda_container = "ARM_LAMBDA_CONTAINER",
        .linux_ec2 = "LINUX_EC2",
        .arm_ec2 = "ARM_EC2",
        .windows_ec2 = "WINDOWS_EC2",
        .mac_arm = "MAC_ARM",
    };
};
