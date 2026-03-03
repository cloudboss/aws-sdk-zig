const PciId = @import("pci_id.zig").PciId;
const ProductCode = @import("product_code.zig").ProductCode;
const FpgaImageState = @import("fpga_image_state.zig").FpgaImageState;
const Tag = @import("tag.zig").Tag;

/// Describes an Amazon FPGA image (AFI).
pub const FpgaImage = struct {
    /// The date and time the AFI was created.
    create_time: ?i64 = null,

    /// Indicates whether data retention support is enabled for the AFI.
    data_retention_support: ?bool = null,

    /// The description of the AFI.
    description: ?[]const u8 = null,

    /// The global FPGA image identifier (AGFI ID).
    fpga_image_global_id: ?[]const u8 = null,

    /// The FPGA image identifier (AFI ID).
    fpga_image_id: ?[]const u8 = null,

    /// The instance types supported by the AFI.
    instance_types: ?[]const []const u8 = null,

    /// The name of the AFI.
    name: ?[]const u8 = null,

    /// The alias of the AFI owner. Possible values include `self`, `amazon`, and
    /// `aws-marketplace`.
    owner_alias: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that owns the AFI.
    owner_id: ?[]const u8 = null,

    /// Information about the PCI bus.
    pci_id: ?PciId = null,

    /// The product codes for the AFI.
    product_codes: ?[]const ProductCode = null,

    /// Indicates whether the AFI is public.
    public: ?bool = null,

    /// The version of the Amazon Web Services Shell that was used to create the
    /// bitstream.
    shell_version: ?[]const u8 = null,

    /// Information about the state of the AFI.
    state: ?FpgaImageState = null,

    /// Any tags assigned to the AFI.
    tags: ?[]const Tag = null,

    /// The time of the most recent update to the AFI.
    update_time: ?i64 = null,
};
