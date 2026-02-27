pub const AcceleratorManufacturer = enum {
    amazon_web_services,
    amd,
    nvidia,
    xilinx,
    habana,

    pub const json_field_names = .{
        .amazon_web_services = "AMAZON_WEB_SERVICES",
        .amd = "AMD",
        .nvidia = "NVIDIA",
        .xilinx = "XILINX",
        .habana = "HABANA",
    };
};
