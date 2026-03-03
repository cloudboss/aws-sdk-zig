const std = @import("std");

pub const ImageReferenceResourceType = enum {
    ec2_instance,
    ec2_launch_template,
    ssm_parameter,
    image_builder_image_recipe,
    image_builder_container_recipe,

    pub const json_field_names = .{
        .ec2_instance = "ec2:Instance",
        .ec2_launch_template = "ec2:LaunchTemplate",
        .ssm_parameter = "ssm:Parameter",
        .image_builder_image_recipe = "imagebuilder:ImageRecipe",
        .image_builder_container_recipe = "imagebuilder:ContainerRecipe",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ec2_instance => "ec2:Instance",
            .ec2_launch_template => "ec2:LaunchTemplate",
            .ssm_parameter => "ssm:Parameter",
            .image_builder_image_recipe => "imagebuilder:ImageRecipe",
            .image_builder_container_recipe => "imagebuilder:ContainerRecipe",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
