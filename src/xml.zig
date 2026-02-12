const std = @import("std");
const testing = std.testing;

/// Streaming XML event parser operating on a complete `[]const u8` buffer.
/// No allocations required for the reader itself -- returned slices borrow
/// from the source buffer.
pub const Reader = struct {
    source: []const u8,
    pos: usize = 0,
    /// When a self-closing tag is encountered, we emit element_start first,
    /// then element_end on the next call.
    pending_end: bool = false,

    pub fn init(source: []const u8) Reader {
        return .{ .source = source };
    }

    /// Returns the next event, or null at end of input.
    pub fn next(self: *Reader) Error!?Event {
        while (true) {
            if (self.pending_end) {
                self.pending_end = false;
                return .element_end;
            }

            self.skipWhitespace();
            if (self.pos >= self.source.len) return null;

            if (self.source[self.pos] == '<') {
                if (self.parseTag()) |ev| return ev else continue;
            }

            // Text content
            const start = self.pos;
            while (self.pos < self.source.len and self.source[self.pos] != '<') {
                self.pos += 1;
            }
            return .{ .text = self.source[start..self.pos] };
        }
    }

    /// After receiving `.element_start`, reads text content up to the matching
    /// `</tag>` and returns a borrowed slice. Consumes the end tag.
    /// Skips any child elements encountered before text.
    pub fn readElementText(self: *Reader) Error![]const u8 {
        // Handle self-closing tags (pending_end means no content)
        if (self.pending_end) {
            self.pending_end = false;
            return "";
        }

        // Collect text, skipping child elements
        var depth: usize = 0;
        const start = self.pos;
        var text_start = start;
        var text_end = start;

        while (self.pos < self.source.len) {
            if (self.source[self.pos] == '<') {
                if (self.pos + 1 < self.source.len and self.source[self.pos + 1] == '/') {
                    if (depth == 0) {
                        text_end = self.pos;
                        // Skip </tag>
                        self.pos += 2;
                        self.skipUntilAfter('>');
                        return self.source[text_start..text_end];
                    } else {
                        depth -= 1;
                        self.pos += 2;
                        self.skipUntilAfter('>');
                        if (depth == 0) text_start = self.pos;
                    }
                } else if (self.pos + 1 < self.source.len and self.source[self.pos + 1] == '!') {
                    // Comment
                    self.skipComment();
                } else if (self.pos + 1 < self.source.len and self.source[self.pos + 1] == '?') {
                    // Processing instruction
                    self.skipProcessingInstruction();
                } else {
                    // Opening tag -- check for self-closing
                    if (self.isSelfClosingTag()) {
                        self.skipUntilAfter('>');
                        // Self-closing doesn't change depth
                    } else {
                        depth += 1;
                        self.skipUntilAfter('>');
                    }
                    text_start = self.pos;
                }
            } else {
                self.pos += 1;
            }
        }
        return error.UnexpectedEndOfInput;
    }

    /// After receiving `.element_start`, skips the entire element including
    /// all children until the matching `</tag>`.
    pub fn skipElement(self: *Reader) Error!void {
        if (self.pending_end) {
            self.pending_end = false;
            return;
        }

        var depth: usize = 1;
        while (self.pos < self.source.len) {
            if (self.source[self.pos] == '<') {
                if (self.pos + 1 < self.source.len and self.source[self.pos + 1] == '/') {
                    depth -= 1;
                    self.pos += 2;
                    self.skipUntilAfter('>');
                    if (depth == 0) return;
                } else if (self.pos + 1 < self.source.len and self.source[self.pos + 1] == '!') {
                    self.skipComment();
                } else if (self.pos + 1 < self.source.len and self.source[self.pos + 1] == '?') {
                    self.skipProcessingInstruction();
                } else {
                    if (self.isSelfClosingTag()) {
                        self.skipUntilAfter('>');
                    } else {
                        depth += 1;
                        self.skipUntilAfter('>');
                    }
                }
            } else {
                self.pos += 1;
            }
        }
        return error.UnexpectedEndOfInput;
    }

    /// Parses a tag starting at '<'. Returns null for comments/PIs (caller loops).
    fn parseTag(self: *Reader) ?Event {
        std.debug.assert(self.source[self.pos] == '<');
        self.pos += 1;

        if (self.pos >= self.source.len) return null;

        // Comment: <!-- ... -->
        if (self.source[self.pos] == '!' and self.pos + 1 < self.source.len and
            self.source[self.pos + 1] == '-')
        {
            self.pos -= 1; // back to '<'
            self.skipComment();
            return null; // caller loops
        }

        // Processing instruction: <?...?>
        if (self.source[self.pos] == '?') {
            self.pos -= 1; // back to '<'
            self.skipProcessingInstruction();
            return null; // caller loops
        }

        // End tag: </name>
        if (self.source[self.pos] == '/') {
            self.skipUntilAfter('>');
            return .element_end;
        }

        // Start tag: <name ...> or <name .../>
        const name_start = self.pos;
        while (self.pos < self.source.len and
            self.source[self.pos] != '>' and
            self.source[self.pos] != ' ' and
            self.source[self.pos] != '/' and
            self.source[self.pos] != '\t' and
            self.source[self.pos] != '\n' and
            self.source[self.pos] != '\r')
        {
            self.pos += 1;
        }
        const local = self.source[name_start..self.pos];

        // Skip attributes
        self.skipAttributes();

        if (self.pos < self.source.len and self.source[self.pos] == '/') {
            // Self-closing: <name/>
            self.pos += 1; // skip '/'
            if (self.pos < self.source.len and self.source[self.pos] == '>') {
                self.pos += 1; // skip '>'
            }
            self.pending_end = true;
            return .{ .element_start = .{ .local = local } };
        }

        // Regular opening tag
        if (self.pos < self.source.len and self.source[self.pos] == '>') {
            self.pos += 1;
        }

        return .{ .element_start = .{ .local = local } };
    }

    fn skipAttributes(self: *Reader) void {
        while (self.pos < self.source.len and
            self.source[self.pos] != '>' and
            self.source[self.pos] != '/')
        {
            if (self.source[self.pos] == '"') {
                self.pos += 1;
                while (self.pos < self.source.len and self.source[self.pos] != '"') {
                    self.pos += 1;
                }
                if (self.pos < self.source.len) self.pos += 1;
            } else if (self.source[self.pos] == '\'') {
                self.pos += 1;
                while (self.pos < self.source.len and self.source[self.pos] != '\'') {
                    self.pos += 1;
                }
                if (self.pos < self.source.len) self.pos += 1;
            } else {
                self.pos += 1;
            }
        }
    }

    fn isSelfClosingTag(self: *Reader) bool {
        // Scan forward to find > and check if preceded by /
        var p = self.pos;
        while (p < self.source.len and self.source[p] != '>') {
            if (self.source[p] == '"') {
                p += 1;
                while (p < self.source.len and self.source[p] != '"') p += 1;
                if (p < self.source.len) p += 1;
            } else if (self.source[p] == '\'') {
                p += 1;
                while (p < self.source.len and self.source[p] != '\'') p += 1;
                if (p < self.source.len) p += 1;
            } else {
                p += 1;
            }
        }
        return p > 0 and self.source[p - 1] == '/';
    }

    fn skipWhitespace(self: *Reader) void {
        while (self.pos < self.source.len) {
            switch (self.source[self.pos]) {
                ' ', '\t', '\n', '\r' => self.pos += 1,
                else => return,
            }
        }
    }

    fn skipUntilAfter(self: *Reader, char: u8) void {
        while (self.pos < self.source.len and self.source[self.pos] != char) {
            self.pos += 1;
        }
        if (self.pos < self.source.len) self.pos += 1;
    }

    fn skipComment(self: *Reader) void {
        // Expects position at '<'
        // Skip past -->
        while (self.pos + 2 < self.source.len) {
            if (self.source[self.pos] == '-' and
                self.source[self.pos + 1] == '-' and
                self.source[self.pos + 2] == '>')
            {
                self.pos += 3;
                return;
            }
            self.pos += 1;
        }
        self.pos = self.source.len;
    }

    fn skipProcessingInstruction(self: *Reader) void {
        // Expects position at '<'
        // Skip past ?>
        while (self.pos + 1 < self.source.len) {
            if (self.source[self.pos] == '?' and self.source[self.pos + 1] == '>') {
                self.pos += 2;
                return;
            }
            self.pos += 1;
        }
        self.pos = self.source.len;
    }
};

pub const Event = union(enum) {
    element_start: ElementStart,
    element_end,
    text: []const u8,
};

pub const ElementStart = struct {
    local: []const u8,
};

pub const Error = error{
    UnexpectedEndOfInput,
};

// ---- Tests ----

test "simple element" {
    var reader = Reader.init("<Name>Alice</Name>");
    const start = (try reader.next()).?;
    try testing.expectEqualStrings("Name", start.element_start.local);
    const text = (try reader.next()).?;
    try testing.expectEqualStrings("Alice", text.text);
    const end = (try reader.next()).?;
    try testing.expect(end == .element_end);
    try testing.expect(try reader.next() == null);
}

test "nested elements" {
    var reader = Reader.init("<A><B>hello</B><C>world</C></A>");
    try testing.expectEqualStrings("A", (try reader.next()).?.element_start.local);
    try testing.expectEqualStrings("B", (try reader.next()).?.element_start.local);
    try testing.expectEqualStrings("hello", (try reader.next()).?.text);
    try testing.expect((try reader.next()).? == .element_end); // </B>
    try testing.expectEqualStrings("C", (try reader.next()).?.element_start.local);
    try testing.expectEqualStrings("world", (try reader.next()).?.text);
    try testing.expect((try reader.next()).? == .element_end); // </C>
    try testing.expect((try reader.next()).? == .element_end); // </A>
    try testing.expect(try reader.next() == null);
}

test "self-closing tag" {
    var reader = Reader.init("<Root><Empty/><Other>x</Other></Root>");
    try testing.expectEqualStrings("Root", (try reader.next()).?.element_start.local);
    try testing.expectEqualStrings("Empty", (try reader.next()).?.element_start.local);
    try testing.expect((try reader.next()).? == .element_end); // self-close end
    try testing.expectEqualStrings("Other", (try reader.next()).?.element_start.local);
    try testing.expectEqualStrings("x", (try reader.next()).?.text);
    try testing.expect((try reader.next()).? == .element_end); // </Other>
    try testing.expect((try reader.next()).? == .element_end); // </Root>
}

test "readElementText" {
    var reader = Reader.init("<Root><Name>Alice</Name><Age>30</Age></Root>");
    _ = try reader.next(); // <Root>
    _ = try reader.next(); // <Name>
    const name = try reader.readElementText();
    try testing.expectEqualStrings("Alice", name);
    _ = try reader.next(); // <Age>
    const age = try reader.readElementText();
    try testing.expectEqualStrings("30", age);
    try testing.expect((try reader.next()).? == .element_end); // </Root>
}

test "readElementText with nested children skips them" {
    // readElementText skips child elements and returns any trailing text before </tag>
    var reader = Reader.init("<Outer><Inner><Deep>x</Deep>tail</Inner></Outer>");
    _ = try reader.next(); // <Outer>
    _ = try reader.next(); // <Inner>
    const text = try reader.readElementText();
    try testing.expectEqualStrings("tail", text);
}

test "readElementText with only child elements returns empty" {
    var reader = Reader.init("<Outer><Inner><Deep>x</Deep></Inner></Outer>");
    _ = try reader.next(); // <Outer>
    _ = try reader.next(); // <Inner>
    const text = try reader.readElementText();
    try testing.expectEqualStrings("", text);
}

test "readElementText on self-closing" {
    var reader = Reader.init("<Root><Empty/></Root>");
    _ = try reader.next(); // <Root>
    _ = try reader.next(); // <Empty/>
    const text = try reader.readElementText();
    try testing.expectEqualStrings("", text);
    try testing.expect((try reader.next()).? == .element_end); // </Root>
}

test "skipElement" {
    var reader = Reader.init("<Root><Skip><A>1</A><B>2</B></Skip><Keep>3</Keep></Root>");
    _ = try reader.next(); // <Root>
    _ = try reader.next(); // <Skip>
    try reader.skipElement(); // skip everything in <Skip>
    try testing.expectEqualStrings("Keep", (try reader.next()).?.element_start.local);
    try testing.expectEqualStrings("3", (try reader.next()).?.text);
}

test "skipElement on self-closing" {
    var reader = Reader.init("<Root><Empty/><Next>ok</Next></Root>");
    _ = try reader.next(); // <Root>
    _ = try reader.next(); // <Empty/>
    try reader.skipElement();
    try testing.expectEqualStrings("Next", (try reader.next()).?.element_start.local);
}

test "comments are skipped" {
    var reader = Reader.init("<!-- comment --><Root>text</Root>");
    try testing.expectEqualStrings("Root", (try reader.next()).?.element_start.local);
    try testing.expectEqualStrings("text", (try reader.next()).?.text);
    try testing.expect((try reader.next()).? == .element_end);
}

test "processing instructions are skipped" {
    var reader = Reader.init("<?xml version=\"1.0\"?><Root>ok</Root>");
    try testing.expectEqualStrings("Root", (try reader.next()).?.element_start.local);
    try testing.expectEqualStrings("ok", (try reader.next()).?.text);
}

test "attributes are skipped" {
    var reader = Reader.init("<Root xmlns=\"http://example.com\" id=\"1\"><Name attr=\"v\">test</Name></Root>");
    try testing.expectEqualStrings("Root", (try reader.next()).?.element_start.local);
    try testing.expectEqualStrings("Name", (try reader.next()).?.element_start.local);
    try testing.expectEqualStrings("test", (try reader.next()).?.text);
}

test "AWS-style response" {
    const xml =
        \\<?xml version="1.0" encoding="UTF-8"?>
        \\<GetCallerIdentityResponse xmlns="https://sts.amazonaws.com/doc/2011-06-15/">
        \\  <GetCallerIdentityResult>
        \\    <Arn>arn:aws:iam::123456789012:user/test</Arn>
        \\    <UserId>AIDACKCEVSQ6C2EXAMPLE</UserId>
        \\    <Account>123456789012</Account>
        \\  </GetCallerIdentityResult>
        \\  <ResponseMetadata>
        \\    <RequestId>01234567-89ab-cdef-0123-456789abcdef</RequestId>
        \\  </ResponseMetadata>
        \\</GetCallerIdentityResponse>
    ;

    var reader = Reader.init(xml);

    // <GetCallerIdentityResponse>
    try testing.expectEqualStrings("GetCallerIdentityResponse", (try reader.next()).?.element_start.local);
    // <GetCallerIdentityResult>
    try testing.expectEqualStrings("GetCallerIdentityResult", (try reader.next()).?.element_start.local);
    // <Arn>
    try testing.expectEqualStrings("Arn", (try reader.next()).?.element_start.local);
    const arn = try reader.readElementText();
    try testing.expectEqualStrings("arn:aws:iam::123456789012:user/test", arn);
    // <UserId>
    try testing.expectEqualStrings("UserId", (try reader.next()).?.element_start.local);
    const user_id = try reader.readElementText();
    try testing.expectEqualStrings("AIDACKCEVSQ6C2EXAMPLE", user_id);
    // <Account>
    try testing.expectEqualStrings("Account", (try reader.next()).?.element_start.local);
    const account = try reader.readElementText();
    try testing.expectEqualStrings("123456789012", account);
    // </GetCallerIdentityResult>
    try testing.expect((try reader.next()).? == .element_end);
    // <ResponseMetadata>
    try testing.expectEqualStrings("ResponseMetadata", (try reader.next()).?.element_start.local);
    try reader.skipElement();
    // </GetCallerIdentityResponse>
    try testing.expect((try reader.next()).? == .element_end);
}
