describe("facebook", () => {
  it("should have facebook title", async () => {
    await browser.url("https://facebook.com");
    const title = await browser.getTitle();
    expect(title).toBeTruthy();
  });
});
