import tkinter as tk
from tkinter import messagebox, Toplevel
import random
import math

# Read names from file
with open("names.txt", "r") as f:
    names = [line.strip() for line in f if line.strip()]

if not names:
    raise Exception("No names found in names.txt")

root = tk.Tk()
root.title("Lucky Draw Spinner")
root.geometry("750x750")
root.configure(bg="#f0f0f0")

canvas = tk.Canvas(root, width=650, height=650, bg="white", highlightthickness=0)
canvas.pack(pady=10)

center_x = 325
center_y = 325
radius = 280

colors = [
    "red", "orange", "yellow", "green",
    "cyan", "blue", "purple", "pink"
]

current_angle = 0
spinning = False


# Gradient background
def draw_gradient(canvas, width, height, color1, color2):
    r1, g1, b1 = root.winfo_rgb(color1)
    r2, g2, b2 = root.winfo_rgb(color2)
    r_ratio = (r2 - r1) / height
    g_ratio = (g2 - g1) / height
    b_ratio = (b2 - b1) / height

    for i in range(height):
        nr = int(r1 + (r_ratio * i))
        ng = int(g1 + (g_ratio * i))
        nb = int(b1 + (b_ratio * i))
        color = f"#{nr//256:02x}{ng//256:02x}{nb//256:02x}"
        canvas.create_line(0, i, width, i, fill=color)


def draw_wheel(angle_offset=0):
    canvas.delete("all")
    draw_gradient(canvas, 650, 650, "#d0f0ff", "#ffffff")

    n = len(names)
    angle_per_slice = 360 / n

    for i, name in enumerate(names):
        start = i * angle_per_slice + angle_offset

        canvas.create_arc(
            center_x - radius,
            center_y - radius,
            center_x + radius,
            center_y + radius,
            start=start,
            extent=angle_per_slice,
            fill=colors[i % len(colors)],
            outline="white",
            width=2
        )

        text_angle = math.radians(start + angle_per_slice / 2)
        tx = center_x + (radius * 0.65) * math.cos(text_angle)
        ty = center_y - (radius * 0.65) * math.sin(text_angle)

        canvas.create_text(
            tx, ty,
            text=name,
            font=("Arial", 12, "bold"),
            fill="black"
        )

    # Sleek pointer
    canvas.create_polygon(
    center_x, center_y - radius,          # short edge tip (near wheel)
    center_x - 25, center_y - radius - 30,  # left outward point
    center_x + 25, center_y - radius - 30,  # right outward point
    fill="black", outline="gold", width=3
)


def start_spin():
    global spinning
    if spinning:
        return
    spinning = True
    total_rotation =1000# random.randint(1500, 3000)
    spin(total_rotation, 20)


def spin(remaining, speed):
    global current_angle, spinning
    if remaining <= 0:
        spinning = False
        announce_winner()
        return

    current_angle = (current_angle + speed) % 360
    draw_wheel(current_angle)

    remaining -= speed
    if speed > 2:
        speed *= 0.98

    root.after(20, lambda: spin(remaining, speed))


def announce_winner():
    global names
    n = len(names)
    angle_per_slice = 360 / n
    pointer_angle = (90 - current_angle) % 360
    winner_index = int(pointer_angle // angle_per_slice)
    winner_index = min(winner_index, len(names) - 1)
    winner = names[winner_index]

    # Custom popup instead of plain messagebox
    popup = Toplevel(root)
    popup.title("Winner!")
    popup.geometry("300x200")
    popup.configure(bg="#ffebcd")

    tk.Label(
        popup,
        text="🎉 Winner 🎉",
        font=("Arial", 18, "bold"),
        fg="darkred",
        bg="#ffebcd"
    ).pack(pady=10)

    tk.Label(
        popup,
        text=winner,
        font=("Arial", 16, "bold"),
        fg="blue",
        bg="#ffebcd"
    ).pack(pady=10)

    tk.Button(
        popup,
        text="OK",
        font=("Arial", 12, "bold"),
        bg="green",
        fg="white",
        command=popup.destroy
    ).pack(pady=10)

    with open("winners.txt", "a") as f:
        f.write(winner + "\n")

    names.pop(winner_index)

    if len(names) == 0:
        messagebox.showinfo("Completed", "All participants have been selected!")
        spin_button.config(state="disabled")
        canvas.delete("all")
        canvas.create_text(
            center_x, center_y,
            text="No Participants Left",
            font=("Arial", 24, "bold"),
            fill="red"
        )


draw_wheel(current_angle)

# Styled spin button
spin_button = tk.Button(
    root,
    text="SPIN",
    font=("Arial", 20, "bold"),
    bg="#32CD32",
    fg="white",
    activebackground="#228B22",
    activeforeground="white",
    relief="raised",
    bd=5,
    command=start_spin
)
spin_button.pack(pady=15)

root.mainloop()
