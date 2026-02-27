const DolbyEProgramSelection = @import("dolby_e_program_selection.zig").DolbyEProgramSelection;

/// Audio Dolby EDecode
pub const AudioDolbyEDecode = struct {
    /// Applies only to Dolby E. Enter the program ID (according to the metadata in
    /// the audio) of the Dolby E program to extract from the specified track. One
    /// program extracted per audio selector. To select multiple programs, create
    /// multiple selectors with the same Track and different Program numbers. “All
    /// channels” means to ignore the program IDs and include all the channels in
    /// this selector; useful if metadata is known to be incorrect.
    program_selection: DolbyEProgramSelection,

    pub const json_field_names = .{
        .program_selection = "ProgramSelection",
    };
};
