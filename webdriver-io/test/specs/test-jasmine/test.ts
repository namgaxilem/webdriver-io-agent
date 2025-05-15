describe("asdasd.com", () => {
  it("should have a asdasd title", async () => {
    await browser.url("https://ccc.com");
    const title = await browser.getTitle();
    expect(title).toBeTruthy();
  });
});
