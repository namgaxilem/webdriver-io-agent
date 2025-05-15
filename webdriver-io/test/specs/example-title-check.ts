describe("Example.com", () => {
  it("should have a non-null title", async () => {
    await browser.url("https://example.com");
    const title = await browser.getTitle();
    expect(title).toBeTruthy();
  });
});
