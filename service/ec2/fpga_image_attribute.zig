const LoadPermission = @import("load_permission.zig").LoadPermission;
const ProductCode = @import("product_code.zig").ProductCode;

/// Describes an Amazon FPGA image (AFI) attribute.
pub const FpgaImageAttribute = struct {
    /// The description of the AFI.
    description: ?[]const u8 = null,

    /// The ID of the AFI.
    fpga_image_id: ?[]const u8 = null,

    /// The load permissions.
    load_permissions: ?[]const LoadPermission = null,

    /// The name of the AFI.
    name: ?[]const u8 = null,

    /// The product codes.
    product_codes: ?[]const ProductCode = null,
};
