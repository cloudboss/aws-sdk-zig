const std = @import("std");

pub const Event = enum {
    website_interact,
    file_download_from_secure_browser_to_remote_disk,
    file_transfer_from_remote_to_local_disk,
    file_transfer_from_local_to_remote_disk,
    file_upload_from_remote_disk_to_secure_browser,
    content_paste_to_website,
    content_transfer_from_local_to_remote_clipboard,
    content_copy_from_website,
    url_load,
    tab_open,
    tab_close,
    print_job_submit,
    session_connect,
    session_start,
    session_disconnect,
    session_end,
    url_block_by_content_filter,

    pub const json_field_names = .{
        .website_interact = "WebsiteInteract",
        .file_download_from_secure_browser_to_remote_disk = "FileDownloadFromSecureBrowserToRemoteDisk",
        .file_transfer_from_remote_to_local_disk = "FileTransferFromRemoteToLocalDisk",
        .file_transfer_from_local_to_remote_disk = "FileTransferFromLocalToRemoteDisk",
        .file_upload_from_remote_disk_to_secure_browser = "FileUploadFromRemoteDiskToSecureBrowser",
        .content_paste_to_website = "ContentPasteToWebsite",
        .content_transfer_from_local_to_remote_clipboard = "ContentTransferFromLocalToRemoteClipboard",
        .content_copy_from_website = "ContentCopyFromWebsite",
        .url_load = "UrlLoad",
        .tab_open = "TabOpen",
        .tab_close = "TabClose",
        .print_job_submit = "PrintJobSubmit",
        .session_connect = "SessionConnect",
        .session_start = "SessionStart",
        .session_disconnect = "SessionDisconnect",
        .session_end = "SessionEnd",
        .url_block_by_content_filter = "UrlBlockByContentFilter",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .website_interact => "WebsiteInteract",
            .file_download_from_secure_browser_to_remote_disk => "FileDownloadFromSecureBrowserToRemoteDisk",
            .file_transfer_from_remote_to_local_disk => "FileTransferFromRemoteToLocalDisk",
            .file_transfer_from_local_to_remote_disk => "FileTransferFromLocalToRemoteDisk",
            .file_upload_from_remote_disk_to_secure_browser => "FileUploadFromRemoteDiskToSecureBrowser",
            .content_paste_to_website => "ContentPasteToWebsite",
            .content_transfer_from_local_to_remote_clipboard => "ContentTransferFromLocalToRemoteClipboard",
            .content_copy_from_website => "ContentCopyFromWebsite",
            .url_load => "UrlLoad",
            .tab_open => "TabOpen",
            .tab_close => "TabClose",
            .print_job_submit => "PrintJobSubmit",
            .session_connect => "SessionConnect",
            .session_start => "SessionStart",
            .session_disconnect => "SessionDisconnect",
            .session_end => "SessionEnd",
            .url_block_by_content_filter => "UrlBlockByContentFilter",
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
