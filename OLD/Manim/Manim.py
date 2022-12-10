from manim import *
class vi(Scene):
    def construct(self):
        sq=Square(color=RED_D)
        sq.flip(RIGHT)
        Wait(12)
        sq.rotate(-3 * TAU /8)
        self.play(GrowFromCenter(sq))