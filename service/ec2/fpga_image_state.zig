const FpgaImageStateCode = @import("fpga_image_state_code.zig").FpgaImageStateCode;

/// Describes the state of the bitstream generation process for an Amazon FPGA
/// image (AFI).
pub const FpgaImageState = struct {
    /// The state. The following are the possible values:
    ///
    /// * `pending` - AFI bitstream generation is in progress.
    ///
    /// * `available` - The AFI is available for use.
    ///
    /// * `failed` - AFI bitstream generation failed.
    ///
    /// * `unavailable` - The AFI is no longer available for use.
    code: ?FpgaImageStateCode,

    /// If the state is `failed`, this is the error message.
    message: ?[]const u8,
};
