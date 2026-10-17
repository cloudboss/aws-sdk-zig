const VideoColorimetry = @import("video_colorimetry.zig").VideoColorimetry;
const VideoMatrixCoefficients = @import("video_matrix_coefficients.zig").VideoMatrixCoefficients;
const VideoTransferCharacteristics = @import("video_transfer_characteristics.zig").VideoTransferCharacteristics;

/// The color signaling of the video stream.
pub const ColorInformation = struct {
    /// The color primaries that the video stream uses (for example, `BT709` or
    /// `BT2020`).
    colorimetry: ?VideoColorimetry = null,

    /// The YCbCr matrix coefficients that the video stream uses (for example,
    /// `BT709` or `BT2020_NCL`).
    matrix_coefficients: ?VideoMatrixCoefficients = null,

    /// The transfer characteristics that the video stream uses (for example,
    /// `BT601`, `BT709`, `BT2100_PQ`, or `BT2100_HLG`).
    transfer_characteristics: ?VideoTransferCharacteristics = null,

    pub const json_field_names = .{
        .colorimetry = "Colorimetry",
        .matrix_coefficients = "MatrixCoefficients",
        .transfer_characteristics = "TransferCharacteristics",
    };
};
